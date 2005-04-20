From: David Greaves <david@dgreaves.com>
Subject: Re: sending commands to the SATA drive
Date: Wed, 20 Apr 2005 09:05:47 +0100
Message-ID: <42660D5B.3000100@dgreaves.com>
References: <OFC848C2D3.F3F922F3-ON48256FE8.002B7BD9@adtx.com.ph>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from s2.ukfsn.org ([217.158.120.143]:63949 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261469AbVDTIFt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 20 Apr 2005 04:05:49 -0400
In-Reply-To: <OFC848C2D3.F3F922F3-ON48256FE8.002B7BD9@adtx.com.ph>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Laddie Michael C Zarsuelo/adtxp <lzarsuelo@adtx.com.ph>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Laddie Michael C Zarsuelo/adtxp wrote:
> Greetings!
> 
> I'm quite new to Linux and I need to create a monitoring program for our
> SATA hdd's.  I have to be able to send smart status commands to the drive.

AFAIK this isn't yet supported in the released version of libata.
It is however in the dev version and in need of some testing.

Search the list archives for
* libata-dev
* ATA passthru (a.k.a. SMART) support

Look for messages Jeff Garzik and John W. Linville

HTH

David

-- 
