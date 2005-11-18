From: Brett Russ <bruss@alum.wpi.edu>
Subject: Re: [PATCH] Marvell SATA fixes v2
Date: Fri, 18 Nov 2005 08:37:09 -0500
Message-ID: <f990dfce0511180537i4becb5f1k611a58874e9bf972@mail.gmail.com>
References: <20051114050404.GA18144@havoc.gtf.org>
	 <Pine.LNX.4.63.0511151437320.3015@dingo.iwr.uni-heidelberg.de>
	 <4379F31D.4000508@pobox.com>
	 <Pine.LNX.4.63.0511152108140.3015@dingo.iwr.uni-heidelberg.de>
	 <437D2DED.5030602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.198]:41572 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750729AbVKRNhK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Nov 2005 08:37:10 -0500
Received: by wproxy.gmail.com with SMTP id i1so356762wra
        for <linux-ide@vger.kernel.org>; Fri, 18 Nov 2005 05:37:09 -0800 (PST)
In-Reply-To: <437D2DED.5030602@pobox.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/17/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> See if you can give the latest git tree a try (what will be
> 2.6.15-rc1-git6, later tonight).  I think I've killed most of the
> sata_mv bugs, and have it working here on both 50xx and 60xx.

Hey Jeff,

Been reading the patches you've been sending.  Thanks for picking it
up--there's no way I have time to work on it lately.  Glad to hear you
got it working on 50xx.  Some comments:

-in the future, can you separate whitespace only patch mailings with
functional patches?  I know that's something you request of others,
but it helps us too.

-the version # of sata_mv doesn't look like it was bumped.  Did I miss it?

thanks,
BR
