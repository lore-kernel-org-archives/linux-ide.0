From: Gwendal Grignou <gwendal@google.com>
Subject: Re: ata: HDIO_DRIVE_* ioctl() Linux 3.9 regression
Date: Fri, 29 Mar 2013 08:28:03 -0700
Message-ID: <CAMHSBOUcy-yy3G8GdCZoAn1UHphy+oYo5OY4s_ceUrt_5m=wng@mail.gmail.com>
References: <CAF1_xX3Ox6=fKomLpvrDxMZ9edB0=2SrVDDPrU0nivD_Yj6KHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAF1_xX3Ox6=fKomLpvrDxMZ9edB0=2SrVDDPrU0nivD_Yj6KHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ronald <ronald645@gmail.com>
Cc: krzysiek@podlesie.net, IDE/ATA development list <linux-ide@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-ide@vger.kernel.org

Ronald [and other],
Sorry for the bug I introduced. I just send a mail with a patch
"[PATCH] [libata] Fix HDIO_DRIVE_CMD ioctl sense data check" that
addresses the problem.

Gwendal.

On Mon, Mar 25, 2013 at 10:26 AM, Ronald <ronald645@gmail.com> wrote:
> In reply to [1]: I have the same issue. Git bisect took 50+ rebuilds xD
>
> Smartd does not work anymore since 84a9a8cd9 ([libata] Set proper SK
> when CK_COND is set.).
>
> I hope I'm not stepping on anyone's toe's by chosing the same title.
> I'm not subscribed to this list.
>
> Just wanted to add a 'me2'
>
> [1] http://www.spinics.net/lists/linux-ide/msg45268.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
