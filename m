From: Mikael Abrahamsson <swmike@swm.pp.se>
Subject: Re: 4k sector size and WD20EARS
Date: Thu, 8 Apr 2010 18:12:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.10.1004081811200.21305@uplift.swm.pp.se>
References: <4BBDE620.3040601@gc-web.de> <yq17hoix78i.fsf@sermon.lab.mkp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from swm.pp.se ([212.247.200.143]:50163 "EHLO uplift.swm.pp.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932718Ab0DHQMi (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 8 Apr 2010 12:12:38 -0400
In-Reply-To: <yq17hoix78i.fsf@sermon.lab.mkp.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Alexander Clausen <alex@gc-web.de>, linux-ide@vger.kernel.org

On Thu, 8 Apr 2010, Martin K. Petersen wrote:

> For unknown reasons these drive report themselves as 512-byte drives
> despite using 4096-byte sectors internally.

It's not unknown, it's for compatibility reasons.

The original poster is well off reading the earlier discussions on 
linux-raid regarding these drives.

-- 
Mikael Abrahamsson    email: swmike@swm.pp.se
