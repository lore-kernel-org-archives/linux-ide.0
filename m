From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] Marvell SATA fixes v2
Date: Fri, 18 Nov 2005 11:08:06 -0500
Message-ID: <437DFC66.3040209@pobox.com>
References: <20051114050404.GA18144@havoc.gtf.org>	 <Pine.LNX.4.63.0511151437320.3015@dingo.iwr.uni-heidelberg.de>	 <4379F31D.4000508@pobox.com>	 <Pine.LNX.4.63.0511152108140.3015@dingo.iwr.uni-heidelberg.de>	 <437D2DED.5030602@pobox.com> <f990dfce0511180537i4becb5f1k611a58874e9bf972@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932302AbVKRQI0@vger.kernel.org>
In-Reply-To: <f990dfce0511180537i4becb5f1k611a58874e9bf972@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brett Russ <bruss@alum.wpi.edu>
Cc: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Brett Russ wrote:
> On 11/17/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>See if you can give the latest git tree a try (what will be
>>2.6.15-rc1-git6, later tonight).  I think I've killed most of the
>>sata_mv bugs, and have it working here on both 50xx and 60xx.
> 
> 
> Hey Jeff,
> 
> Been reading the patches you've been sending.  Thanks for picking it
> up--there's no way I have time to work on it lately.  Glad to hear you
> got it working on 50xx.  Some comments:
> 
> -in the future, can you separate whitespace only patch mailings with
> functional patches?  I know that's something you request of others,
> but it helps us too.

They are separated out in the git repo, and also in the automated 
mailing list git-commits-head@vger.kernel.org.


> -the version # of sata_mv doesn't look like it was bumped.  Did I miss it?

That was intentional:  since sata_mv just went upstream in this upcoming 
release (2.6.15), the version number was already bumped.

	Jeff
