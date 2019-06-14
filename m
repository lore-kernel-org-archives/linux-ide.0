From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [RFC 3/3] ata: sata_mv, avoid trigerrable BUG_ON
Date: Fri, 14 Jun 2019 11:24:46 +0300
Message-ID: <0e9f8a3b-65b9-4d87-21f1-684f7e44b166@cogentembedded.com>
References: <20190614071140.6233-1-jslaby@suse.cz>
 <20190614071140.6233-3-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190614071140.6233-3-jslaby@suse.cz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>, axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Hello!

On 14.06.2019 10:11, Jiri Slaby wrote:

> There are several reports that the BUG_ON on unsupported command in
> mv_qc_prep can be triggered under some circumstances:
> https://bugzilla.suse.com/show_bug.cgi?id=1110252
> https://serverfault.com/questions/888897/raid-problems-after-power-outage
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1652185
> https://bugs.centos.org/view.php?id=14998
> 
> Let sata_mv handle the failure gracefully: warn about that incl. the
> failed command number and return an AC_ERR_INVALID error. We can do that
> now thanks to the previous patch.
> 
> Remove also the long-standing FIXME.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-ide@vger.kernel.org
> ---
>   drivers/ata/sata_mv.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index d6aac7b31c45..144fa0982168 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -2098,12 +2098,10 @@ static int mv_qc_prep(struct ata_queued_cmd *qc)
>   		 * non-NCQ mode are: [RW] STREAM DMA and W DMA FUA EXT, none
>   		 * of which are defined/used by Linux.  If we get here, this
>   		 * driver needs work.
> -		 *
> -		 * FIXME: modify libata to give qc_prep a return value and
> -		 * return error here.
>   		 */
> -		BUG_ON(tf->command);
> -		break;
> +		ata_port_err(ap, "%s: unsupported command: %d\n", __func__,
> +				tf->command);

    I'd use "%x" here instead of "%d".

> +		return AC_ERR_INVALID;
>   	}
>   	mv_crqb_pack_cmd(cw++, tf->nsect, ATA_REG_NSECT, 0);
>   	mv_crqb_pack_cmd(cw++, tf->hob_lbal, ATA_REG_LBAL, 0);

MBR, Sergei
