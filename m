From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Subject: Re: [PATCH] Fix HD activity LED with ahci
Date: Fri, 26 Aug 2005 14:59:36 +0200
Message-ID: <430F1238.2020608@fujitsu-siemens.com>
References: <42EF93F8.8050601@fujitsu-siemens.com>	 <20050802163519.GB3710@suse.de>  <42F05359.7030006@fujitsu-siemens.com> <1123092761.3982.20.camel@lynx.auton.cs.cmu.edu> <42F1BE18.9000105@fujitsu-siemens.com> <430955FC.9080106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:62240 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S1751559AbVHZM75 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 26 Aug 2005 08:59:57 -0400
In-Reply-To: <430955FC.9080106@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>

Jeff Garzik wrote:

> To answer the question everybody was asking, this line was in the code 
> because it was in the patch that got AHCI working.
> 
> I'm inclined to apply the above patch, but I'll wait until 2.6.13, so 
> that we can get some decent testing.

Great. As far as the testing is concerned, we have had no problems with 
the patch here.

Thanks, Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
