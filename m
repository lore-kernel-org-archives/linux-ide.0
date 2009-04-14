From: Mark de Wever <koraq@xs4all.nl>
Subject: Re: [bug#12874] Seagate STT20000A no longer works
Date: Tue, 14 Apr 2009 23:34:23 +0200
Message-ID: <20090414213422.GA2719@localhost>
References: <20090410174247.GA12885@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:4170 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbZDNVnF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 14 Apr 2009 17:43:05 -0400
Content-Disposition: inline
In-Reply-To: <20090410174247.GA12885@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: sshtylyov@ru.mvista.com, bzolnier@gmail.com, linux-ide@vger.kernel.org

On Fri, Apr 10, 2009 at 07:42:47PM +0200, Borislav Petkov wrote:
> Now, without having tested it since I don't have the hardware, would
> something in the lines below be a sensible kludge for now? I guess we
> should have similar error handling for the other MODE SENSE call sites
> and propagate some error status from idetape_get_mode_sense_results()
> upwards to idetape_setup()? 

I tested with 'tmp fix 2' [1] and 'dump drive caps and dbg rqs' [2] and
the patch below applied and had another divide error. Attached the full
dmesg. 

> Yeah, I know, the driver needs a lot of massaging in order even to
> start looking ok... :)

:-)

Do you want me to do the full caps debug test [3] ?

Another question; I'm still using 2.6.29-rc7 as test kernel, do you
prefer to keep using that version or move to 2.6.30-rc1?

[1] http://bugzilla.kernel.org/attachment.cgi?id=20822
[2] http://bugzilla.kernel.org/attachment.cgi?id=20873
[3] http://bugzilla.kernel.org/show_bug.cgi?id=12874#c20

-- 
Regards,
Mark de Wever

> __
> 
> diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
> index 70e7876..827485a 100644
> --- a/drivers/ide/ide-tape.c
> +++ b/drivers/ide/ide-tape.c
> @@ -2095,6 +2095,21 @@ static void idetape_get_mode_sense_results(ide_drive_t *drive)
>  		put_unaligned(540,  (u16 *)&tape->caps[14]);
>  		put_unaligned(6*52, (u16 *)&tape->caps[16]);
>  		return;
> +
> +	} else if ((pc.buf[0] & 0x7f) == 0x70) {
> +		/* unit attention: power on reset or device reset/not ready to
> +		 * ready transition */
> +		if ((pc.buf[2] & 0xf) == 0x6 &&
> +		     (pc.buf[12] == 0x29 || pc.buf[12] == 0x28) &&
> +		     pc.buf[13] == 0x0) {
> +			tape->failed_pc = &pc;
> +			ide_retry_pc(drive, tape->disk);
> +		}
> +		else {
> +			printk(KERN_ERR "%s: error getting caps page\n",
> +					drive->name);
> +			return;
> +		}
>  	}
>  	caps = pc.buf + 4 + pc.buf[3];
