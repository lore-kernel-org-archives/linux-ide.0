From: Tejun Heo <htejun@gmail.com>
Subject: Re: 2.6.20 libata cdrom
Date: Tue, 01 May 2007 15:32:17 +0200
Message-ID: <46374161.3020801@gmail.com>
References: <20070427175205.GD7809@electro-mechanical.com> <4635C35D.1020807@gmail.com> <20070430202107.GF5942@electro-mechanical.com> <4636C2C7.8090206@gmail.com> <46373873.6060704@rtr.ca> <463738BD.2090308@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.239]:37678 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031704AbXEANdm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 May 2007 09:33:42 -0400
Received: by nz-out-0506.google.com with SMTP id o1so2218246nzf
        for <linux-ide@vger.kernel.org>; Tue, 01 May 2007 06:33:41 -0700 (PDT)
In-Reply-To: <463738BD.2090308@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: William Thompson <wt@electro-mechanical.com>, linux-kernel@vger.kernel.org, IDE/ATA development list <linux-ide@vger.kernel.org>, albertcc@tw.ibm.com

Mark Lord wrote:
> And this is the second one today where it would be very useful
> to see a tf dump.  It's time to add one to that code patch, methinks.

Yeah, we have all these fancy ata_msg_() thingies which can be used to
provide a lot of debugging info without affecting hot path.  We're just
too lazy to actually use it. :-( Putting it on my ever growing to-do list.

-- 
tejun
