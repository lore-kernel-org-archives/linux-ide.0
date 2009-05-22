From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Fri, 22 May 2009 21:52:15 +0400
Message-ID: <4A16E64F.6070907@ru.mvista.com>
References: <49CCD7C4.8000207@inov.pt> <200905121923.08159.bzolnier@gmail.com> <4A0AA880.8070209@inov.pt> <200905171720.28640.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:40782 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757188AbZEVRvU (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 22 May 2009 13:51:20 -0400
In-Reply-To: <200905171720.28640.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: =?ISO-8859-15?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>Here's the revised patches, according to the changes you suggested.

> Thanks, I applied set_pio_mode.patch with the following minor fixup:

> @@ -1035,7 +1035,7 @@
>  
>  	ide_port_for_each_dev(i, drive, hwif) {
>  		/*
> -		 * default to PIO Mode 0 before we  figure out
> +		 * default to PIO Mode 0 before we figure out
>  		 * the most suited mode for the attached device
>  		 */
>  		if (port_ops && port_ops->set_pio_mode)

> and will apply the following version of ide_drive_data.patch
> (unless there are some major complains):

> From: Joao Ramos <joao.ramos@inov.pt>
> Subject: ide: do not access ide_drive_t 'drive_data' field directly

> Change ide_drive_t 'drive_data' field from 'unsigned int' type to 'void *'
> type, allowing a wider range of values/types to be stored in this field.

> Added 'ide_get_drivedata' and 'ide_set_drivedata' helpers to get and set
> the 'drive_data' field.

> Fixed all host drivers to maintain coherency with the change in the
> 'drive_data' field type.

> Signed-off-by: Joao Ramos <joao.ramos@inov.pt>
> [bart: fix qd65xx build, cast to 'unsigned long', minor Coding Style fixups]
> Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

Acked-by: Sergei Shtylyov <sshtylyov@ru.montavista.com>

MBR, Sergei
