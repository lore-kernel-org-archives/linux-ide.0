From: Tejun Heo <htejun@gmail.com>
Subject: Re: Promise sata disc sort order
Date: Tue, 23 Oct 2007 16:56:42 +0900
Message-ID: <471DA93A.5010308@gmail.com>
References: <200710071808.l97I8F0s029722@web1.roosit.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:55846 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbXJWH4u (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 23 Oct 2007 03:56:50 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1417579rvb
        for <linux-ide@vger.kernel.org>; Tue, 23 Oct 2007 00:56:49 -0700 (PDT)
In-Reply-To: <200710071808.l97I8F0s029722@web1.roosit.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Marc Roos <marc@roosit.nl>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Marc Roos wrote:
> Jeff,
> 
> Is there a way to bind the sd dives to the sata ports instead of available
> harddrives? 
> 
> For instance 
> 
> Sda is port0 of sata controler0
> Sdb is port1 of sata controler0
> Sdc is port2 of sata controler0
> Sdd is port3 of sata controler0
> 
> If the disk on port2 fails and the system is rebooted. I want the disk on
> port3 still be available under sdd and not changing to sdc.

No.  If you want persistent names, you need to use LABEL or UUID.

-- 
tejun
