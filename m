From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 14/18] ide: add IDE_HFLAG_ABUSE_SET_DMA_MODE host flag
Date: Thu, 15 Nov 2007 21:03:16 +0100
Message-ID: <200711152103.16792.bzolnier@gmail.com>
References: <200711050031.10290.bzolnier@gmail.com> <473C1D9C.5000208@ru.mvista.com> <473C25E1.4040601@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:19091 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761788AbXKOUxB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 Nov 2007 15:53:01 -0500
Received: by nf-out-0910.google.com with SMTP id g13so610014nfb
        for <linux-ide@vger.kernel.org>; Thu, 15 Nov 2007 12:52:59 -0800 (PST)
In-Reply-To: <473C25E1.4040601@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org


Hi,

On Thursday 15 November 2007, Sergei Shtylyov wrote:
> Hello, I wrote:
> 
> >    It's tome that I go and make a patch which deals with 0x00 (default 
> 
>     s/tome/time/
> 
> > PIO mode)...
> 
>     But I'm unsure how this value could reach us form userspace because of the 
> argument check present everywhere that filters out 0 value form being passed 
> -- look at set_xfer_rate() and ide_cmd_ioctl(). So, such fix doesn't seem to 
> be applicable... :-|

You are right, I was mislead by "if (arg < 0 || arg > 70)":

static int set_xfer_rate (ide_drive_t *drive, int arg)
{
	int err;

	if (arg < 0 || arg > 70)
		return -EINVAL;

	err = ide_wait_cmd(drive,
			WIN_SETFEATURES, (u8) arg,
			SETFEATURES_XFER, 0, NULL);

	if (!err && arg) {
		ide_set_xfer_rate(drive, (u8) arg);
		ide_driveid_update(drive);
	}
	return err;
}

but value "1" is still theoretically possible. ;)

Anyway fixing 0x00 is a desirable thing as it is needed for cleanly
handling many older CF cards (they don't support IORDY).

Thanks,
Bart
