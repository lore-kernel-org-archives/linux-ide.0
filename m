From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata-passthrough problem.
Date: Sat, 12 Nov 2005 18:19:42 -0500
Message-ID: <4376788E.9010503@pobox.com>
References: <4375CA38.9000905@superbug.demon.co.uk> <437607B5.7060605@rtr.ca> <43762CEF.2070704@pobox.com> <43764853.5050306@rtr.ca> <43764904.5030309@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dvmed.net ([216.237.124.58]:10386 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964856AbVKLXTq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 12 Nov 2005 18:19:46 -0500
In-Reply-To: <43764904.5030309@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, linux-ide@vger.kernel.org

Mark Lord wrote:
> Speaking of which, these comments are wrong:
> 
> /**
>  *      ata_tf_from_fis - Convert SATA FIS to ATA taskfile
>  *      @fis: Buffer from which data will be input
>  *      @tf: Taskfile to output
>  *
>  *      Converts a standard ATA taskfile to a Serial ATA
>  *      FIS structure (Register - Host to Device).
> ...
> 
> The second comment should probably read something like:
> 
>  *      Converts a serial ATA FIS structure to a
>  *      standard ATA taskfile.

submit a patch, pretty please...

	Jeff



