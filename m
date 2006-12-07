From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] ata: Add support for the MPC52xx ATA controller using
 libata
Date: Thu, 07 Dec 2006 07:20:24 -0500
Message-ID: <45780708.9090300@pobox.com>
References: <4573D90E.3050806@246tNt.com> <11652699172867-git-send-email-tnt@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:37310 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032102AbWLGMU0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 7 Dec 2006 07:20:26 -0500
In-Reply-To: <11652699172867-git-send-email-tnt@246tNt.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Sylvain Munaut wrote:
> This patch adds initial libata support for the Freescale
> MPC5200 integrated IDE controller.
> 
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>

ACK, with one final revision request:  please kill the header, and just 
add that stuff to the top of the .c file.

Resend and I'll apply swiftly :)


