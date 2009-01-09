From: Mark Lord <liml@rtr.ca>
Subject: Re: problems with sata_nv and MV88SX5081 under 2.6.28, fine under2.6.17.6
Date: Fri, 09 Jan 2009 14:46:11 -0500
Message-ID: <4967A983.7040402@rtr.ca>
References: <1231340005.20422.84.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:51858 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbZAITqO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 9 Jan 2009 14:46:14 -0500
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
> 
> for several of the disks, and performance went through the floor because
> of multiple bus resets. Now, the system was running SMART monitoring,
> and in the course of some googling it was suggested that this perhaps
> was causing a timeout, however disabling the smartd made no difference.
> 
> Reverting to 2.6.17.6 made the problem go away, suggesting something
> between 0.7 and 1.24 is causing some difficulty.
..

Yeah, there are vaguely similar reports from som of the 88SX6081 users as well.
I think the restructuring of the reset/probe code last year, to share more
of the libata core/sff stuff, probably messes up the older chipsets like those.

I'm looking into now, so please copy me on any extra postings on this topic.

Eamonn, are you available to test updates early, before they go upstream?

Thanks.

Mark
