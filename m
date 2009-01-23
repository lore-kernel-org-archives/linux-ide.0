From: Mark Lord <liml@rtr.ca>
Subject: Re: sata_mv: basic PIO-only ATAPI support?
Date: Fri, 23 Jan 2009 13:37:25 -0500
Message-ID: <497A0E65.90905@rtr.ca>
References: <49750705.7010709@rtr.ca>	<49750746.3010709@rtr.ca>	<49750774.1070005@rtr.ca>	<49773FD1.3040101@rtr.ca>	<4977C5A5.8070202@gmail.com>	<49780167.1060208@rtr.ca>	<497801F9.2070009@rtr.ca>	<4978028D.3020501@gmail.com>	<4979FC55.1000904@rtr.ca>	<4979FD22.8040407@rtr.ca> <20090123175217.353654de@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:43953 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757057AbZAWSh1 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 23 Jan 2009 13:37:27 -0500
In-Reply-To: <20090123175217.353654de@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>, Jeff Garzik <jgarzik@pobox.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

Alan Cox wrote:
..
> If you want to just force some types of command into using PIO (eg by
> direction, length etc) then use ->check_atapi_dma(qc) - see pata_it821x
> for a worked example.
..

Perfect.  That hook will let me add things very gradually.

Thanks!
