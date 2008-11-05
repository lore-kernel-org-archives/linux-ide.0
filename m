From: James Andrewartha <jamesa@daa.com.au>
Subject: Re: trouble with seagate 1.5TB - 2.6.27.4
Date: Wed, 05 Nov 2008 13:44:28 +0900
Message-ID: <491124AC.2030406@daa.com.au>
References: <000901c93b0a$774ff3d0$b902a8c0@kyle>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from quoll.daa.com.au ([203.17.251.1]:38984 "EHLO quoll.daa.com.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508AbYKEEzV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Nov 2008 23:55:21 -0500
In-Reply-To: <000901c93b0a$774ff3d0$b902a8c0@kyle>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: kyle <kylewong@southa.com>
Cc: linux-ide@vger.kernel.org

kyle wrote:
> Please cc me if possible.
> 
> I just built a new server with some seagate 1.5TB harddisks with mirrored
> /boot and root partition , The system sometime degrade the root partition
> with error message as follow, this happened 4 times within 2 days.

It appears that model of drive is broken:
http://forums.seagate.com/stx/board/message?board.id=ata_drives&thread.id=2390
http://www.techreport.com/discussions.x/15837
Apparently disabling the write cache is a workaround.

-- 
James Andrewartha
