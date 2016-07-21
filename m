From: Tom Yan <tom.ty89@gmail.com>
Subject: Re: [PATCH] libata: add parentheses to avoid a gcc warning
Date: Thu, 21 Jul 2016 17:41:50 +0800
Message-ID: <CAGnHSEnNytfMyiiJ_AqK=QLO=hVdPU-HE8a+bk75m-0_UoguFg@mail.gmail.com>
References: <20160721074023.1522219-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160721074023.1522219-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

The commit has been reverted. The parentheses are actually necessary
since `!=` is of higher precedence than `&`. My bad.

On 21 July 2016 at 15:40, Arnd Bergmann <arnd@arndb.de> wrote:
> gcc-6.1 warns about possibly ambiguous code that was newly added
> to libata:
>
> drivers/ata/libata-scsi.c: In function 'ata_mselect_caching':
> drivers/ata/libata-scsi.c:3637:28: error: suggest parentheses around comparison in operand of '&' [-Werror=parentheses]
> drivers/ata/libata-scsi.c: In function 'ata_mselect_control':
> drivers/ata/libata-scsi.c:3702:28: error: suggest parentheses around comparison in operand of '&' [-Werror=parentheses]
>
> The code is fine, and it's not really ambigous to human readers,
> but let's shut up the warning anyway by adding the parentheses
> that gcc suggests.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 9b7844a8c34a ("libata-scsi: fix read-only bits checking in ata_mselect_*()")
> ---
>  drivers/ata/libata-scsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index fa9d16fe295c..8ad4b237f342 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -3634,7 +3634,7 @@ static int ata_mselect_caching(struct ata_queued_cmd *qc,
>                 /* Check the first byte */
>                 if (i == 0) {
>                         /* except the WCE bit */
> -                       if (mpage[i + 2] & 0xfb != buf[i] & 0xfb) {
> +                       if ((mpage[i + 2] & 0xfb) != (buf[i] & 0xfb)) {
>                                 *fp = i;
>                                 return -EINVAL;
>                         } else {
> @@ -3699,7 +3699,7 @@ static int ata_mselect_control(struct ata_queued_cmd *qc,
>                 /* Check the first byte */
>                 if (i == 0) {
>                         /* except the D_SENSE bit */
> -                       if (mpage[i + 2] & 0xfb != buf[i] & 0xfb) {
> +                       if ((mpage[i + 2] & 0xfb) != (buf[i] & 0xfb)) {
>                                 *fp = i;
>                                 return -EINVAL;
>                         } else {
> --
> 2.9.0
>
