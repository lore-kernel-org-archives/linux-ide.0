From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Pata support on Promise controller under Fedora Core 3
Date: Wed, 27 Oct 2004 10:08:52 -0400
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <417FABF4.6050008@pobox.com>
References: <20041027135800.77927.qmail@web88007.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43688 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262449AbUJ0OJL
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 27 Oct 2004 10:09:11 -0400
In-Reply-To: <20041027135800.77927.qmail@web88007.mail.re2.yahoo.com>
List-Id: linux-ide@vger.kernel.org
To: Ericisko <linux2@rogers.com>
Cc: "James C. Bevier" <jbev@jbsys.com>, linux-ide@vger.kernel.org

Ericisko wrote:
> James,
> 
> you have the same controller as me (PDC20378) which
> has only 1 PATA port. PATA ports support up to 2
> devices per port, as opposed to SATA ports which
> support only 1 device per port.
> There is source code for 2.4 linux driver on Promise
> web site, you can have a look.
> Could you send your dmesg output?


Note that PDC2037x has a "dual master mode", where two PATA devices 
(master/slave) on the same cable can be made to look like two 
independent PATA masters, thus giving the illusion that there are two ports.

	Jeff


