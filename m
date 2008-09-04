From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 5/5] ata_piix: drop merged SCR access and use slave_link
 instead
Date: Thu, 04 Sep 2008 12:36:35 +0200
Message-ID: <48BFBA33.30400@kernel.org>
References: <1217491364-19725-1-git-send-email-tj@kernel.org> <1217491364-19725-6-git-send-email-tj@kernel.org> <48BFBA10.9010102@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:44049 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752543AbYIDKif (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 4 Sep 2008 06:38:35 -0400
In-Reply-To: <48BFBA10.9010102@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk, JosephChan@via.com.tw

Jeff Garzik wrote:
> Tejun Heo wrote:
>> Now that libata has slave_link, there's no need to keep ugly merged
>> SCR access.  Drop it and use slave_link instead.  This results in
>> simpler code and much better separate link handling for master and
>> slave.
>>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
> 
> ACK patchset, patches 1-5
> 
> My only comment is that it would be nice to start moving libata closer
> to SAS, since this seems to parallel some SAS concepts.
> 
> now, off to Puerto Rico for a long weekend!

Enjoy your long weekend.  :-)

-- 
tejun
