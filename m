From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: problems with sata_nv and MV88SX5081 under 2.6.28, fine under2.6.17.6
Date: Wed, 07 Jan 2009 21:13:46 -0600
Message-ID: <49656F6A.3020103@shaw.ca>
References: <1231340005.20422.84.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from idcmail-mo2no.shaw.ca ([64.59.134.9]:63123 "EHLO
	idcmail-mo2no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752240AbZAHDNt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jan 2009 22:13:49 -0500
In-Reply-To: <1231340005.20422.84.camel@ukabzc383.uk.saic.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Cc: linux-ide@vger.kernel.org

Eamonn Hamilton wrote:
> Hi,
> 
> I look after a server with a bunch of drives hooked up to two 8 port
> PCI-X sata cards, detected as above.
> 
> The server was running 2.6.17.6 which has sata_mv version 0.7, which
> worked fine. I recently upgraded the kernel to 2.6.18 with version 1.24,
> and started getting
> 
> ata2.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen

Can you post the full output (that part of the message is not very useful..)
