From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide/Kconfig: mark ide-scsi as deprecated
Date: Fri, 5 Sep 2008 19:38:24 +0200
Message-ID: <200809051938.24933.bzolnier@gmail.com>
References: <200808192111.45351.bzolnier@gmail.com> <200809031943.55605.bzolnier@gmail.com> <20080904033222O.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755152AbYIERlD@vger.kernel.org>
In-Reply-To: <20080904033222O.fujita.tomonori@lab.ntt.co.jp>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org


Hi,

On Wednesday 03 September 2008, FUJITA Tomonori wrote:
> On Wed, 3 Sep 2008 19:43:55 +0200
> Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> 
> > On Wednesday 03 September 2008, FUJITA Tomonori wrote:
> > > On Tue, 19 Aug 2008 21:11:44 +0200
> > > Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:
> > > 
> > > > Mark ide-scsi as deprecated and remove stale/bogus documentation.
> > > > 
> > > > Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> > > > ---
> > > >  drivers/ide/Kconfig |   16 +---------------
> > > >  1 file changed, 1 insertion(+), 15 deletions(-)
> > > 
> > > Can we add ide-scsi to Documentation/feature-removal-schedule.txt?
> > 
> > Sure, care to send a patch?
> 
> 2.6.30 is too far?

It is IMHO.

> =
> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Subject: [PATCH] add deprecated ide-scsi to feature-removal-schedule.txt
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> ---
>  Documentation/feature-removal-schedule.txt |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
> index eb1a47b..feb84b0 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -322,3 +322,11 @@ Why:  Accounting can now be enabled/disabled without kernel recompilation.
>        controlled by a kernel/module/sysfs/sysctl parameter.
>  Who:  Krzysztof Piotr Oledzki <ole@ans.pl>
>  
> +---------------------------
> +
> +What: ide-scsi (BLK_DEV_IDESCSI)
> +When: 2.6.30
> +Why:  The 2.6 kernel supports direct writing to ide CD drives, which
> +      eliminates the need for ide-scsi. The new method is more
> +      efficient in every way.
> +Who:  Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Thanks but I thought that you would also want to handle the removal patch?
