1. Global error handler
2. autologout : [timeout] directive track mousemove and keyup -> autologout service -> logout
<banner></banner>
<div timeout>
  <ba-sidebar class="noprint"></ba-sidebar>
  <ba-page-top class="noprint"></ba-page-top>
  <div class="al-main">

    <div class="al-content card-block" style="height: 100%;">
      <ba-content-top *ngIf=""></ba-content-top>
      <router-outlet></router-outlet>
    </div>

    <nae-modal
      [modalTargetId]="'error'"
      [modalTitle]="'Error Tips'"
      [modalSize]="'small'"
      [buttonsGroup]='errorButtons'
      (clickedBtn)="controlModal($event)">
      <div *ngIf="err.errContent">
        <p>{{err.errContent}}</p>
      </div>
    </nae-modal>

    <nae-modal
      [modalTargetId]="'tip'"
      [modalTitle]="'Tips'"
      [modalSize]="'small'"
      [buttonsGroup]='tipButtons'
      (clickedBtn)="tipControlModal($event)">
      <div>
        <p>{{tip}}</p>
      </div>
    </nae-modal>

  </div>
  <footer *ngIf="" class="al-footer clearfix noprint">
    <div class="al-footer-right">Created with <i class="ion-heart"></i></div>
    <div class="al-footer-main clearfix">
      <ul class="al-share clearfix">
        <li><i class="socicon socicon-facebook"></i></li>
        <li><i class="socicon socicon-twitter"></i></li>
        <li><i class="socicon socicon-google"></i></li>
        <li><i class="socicon socicon-github"></i></li>
      </ul>
    </div>
  </footer>
  <ba-back-top position="200"></ba-back-top>
</div>

<!-- Superset dashboard auth pixel-->
<iframe id="viz_auth"
        #viz_auth
        style="display: none; position: absolute;"
        src="">
</iframe>
<!-- End superset dashboard -->

/////////////////////////////////////////////////////////////////////////////
/**
 * Created by s00349082 on 17-6-6.
 */

import { Directive, HostListener } from '@angular/core';
import { AutoLogoutService } from '../../../../services/auto-logout.service';

@Directive({
  selector: '[timeout]',
})

export class UserOperationCounter {

  constructor (private autoLogoutService: AutoLogoutService) {

  }

  @HostListener('mousemove') onMouseMove() {
    this.autoLogoutService.setStartTime();
  }

  @HostListener('document:keyup') onKeyUp() {
    this.autoLogoutService.setStartTime();
  }
}

/////////////////////////////////////////////////
import { Injectable } from '@angular/core';
import { UtilService } from './utils.service';
import { Router } from '@angular/router';
import { GlobalErrorHandler } from './global-error-handler/global-error-handler.service';
import { GlobalError } from './global-error-handler/global-error';
import { AuthenticationService } from './authentication.service';

@Injectable()
export class AutoLogoutService {

  private timer: any;

  private startTime: Date;

  constructor(private utils: UtilService,
              private authenticationService: AuthenticationService,
              private router: Router,
              private globalErrorHandler: GlobalErrorHandler) {
  }

  public setStartTime() {
    if (!this.timer) {
      this.startTimer();
    } else {
      this.startTime = new Date();
    }
  }

  public startTimer() {
    if (!this.timer) {
      this.startTime = new Date();
      this.timer = setInterval(
        () => {
          const timeSpan: number = new Date().getTime() - this.startTime.getTime();
          if (timeSpan > 1000 * 60 * 10) {
            this.stopTimer();
            this.logout();
          }
        },
        1000);
    }
  }

  private stopTimer() {
    if (this.timer) {
      clearInterval(this.timer);
    }
  }

  private logout() {
    const partalError = new GlobalError({});
    partalError.errCode = 100000;
    partalError.errType = 'login';
    // this.utils.setCookie('interrupt_url', this.router.url, 1000 * 60 * 10, '');
    this.globalErrorHandler.setError(partalError);
  }
}
3. angular-jwt
http://jasonwatmore.com/post/2016/08/16/angular-2-jwt-authentication-example-tutorial