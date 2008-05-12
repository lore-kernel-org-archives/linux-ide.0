From: Peter Klotz <peter.klotz@aon.at>
Subject: Re: 2.6.24.*/2.6.25.*: attempt to access beyond end of device
Date: Mon, 12 May 2008 17:20:37 +0200
Message-ID: <48286045.507@aon.at>
References: <4827D626.50903@aon.at> <20080512105942.62607f53@core>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from warsl404pip5.highway.telekom.at ([195.3.96.77]:19067 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751212AbYELPUk (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 12 May 2008 11:20:40 -0400
In-Reply-To: <20080512105942.62607f53@core>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org

Alan Cox wrote:
> Your Ubuntu kernel is clearing the host protected area (the BIOS has
> marked the end part of the disk as 'reserved' - probably for an XP
> restore partition), the base one for some reason is not.
> 
> Set the boot option "libata.ignore_hpa=1". That defaults to zero
> (respecting the BIOS) so that users don't accidentally blow away BIOS
> partitions and restore images, except apparently Ubuntu patch it the
> other way by default.

Thank you very much for clarifying this behavior.

Using "options libata ignore_hpa=1" and rebuilding initrd now lets 
2.6.25.3 boot without problems.

Best regards, Peter.
