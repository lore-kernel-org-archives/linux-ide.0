From: Pat LaVarre <p.lavarre@ieee.org>
Subject: ATA thru SCSI thru USB
Date: Fri, 4 Nov 2005 16:41:09 -0800
Message-ID: <A804F15E-41D6-45C1-A35F-D7A0AF010435@ieee.org>
References: <Pine.LNX.4.44L0.0511021104020.4928-100000@iolanthe.rowland.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sccrmhc13.comcast.net ([204.127.202.64]:35778 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1751386AbVKEAl6 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 4 Nov 2005 19:41:58 -0500
In-Reply-To: <Pine.LNX.4.44L0.0511021104020.4928-100000@iolanthe.rowland.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: USB Storage list <usb-storage@lists.one-eyed-alien.net>, linux-ide@vger.kernel.org

> Date: 2 November 2005 08:05:18 GMT-08:00
> Subject: Re: [usb-storage] [Merging ATA passthru] on   
> integratingSMART/ATA-Security in usb-storage driver
> ...
> Is there any standard way to pass ATA commands over a USB  
> transport?  I've
> never heard of one.

T10.org has drafts of an ATA thru SCSI, thus USB thru SCSI real soon  
now will have an ATA thru SCSI thru USB.

I remember recently there I asked if I could pass ATA Locking By  
Password thru SCSI.

The answer I got sounded like yes the casual observer can intuit how  
to construct the bits and yes reasonably transparent bridges will  
actually pass them thru but technically that draft specification is  
intentionally opaque, guaranteeing results only for what it lists,  
and that list doesn't yet include ATA Locking By Password, vendor- 
specific requests, newly standard requests, etc. etc.

I didn't care myself enough to request authoritative confirmation of  
that paraphrase of what I thought I heard ...
