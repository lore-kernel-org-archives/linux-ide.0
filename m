From: Tejun Heo <tj@kernel.org>
Subject: Re: Fwd: Long delay when booting with SATA DVD on Marvell 88SE6121
Date: Fri, 04 Sep 2009 11:41:41 +0900
Message-ID: <4AA07E65.6040404@kernel.org>
References: <20090817002918.GA2805@gozer.dminteractive.com>	 <4A9BD7DF.8030606@kernel.org>	 <5ffd7e260908311856j1fd42765rbdc5245bf4e7bd71@mail.gmail.com> <5ffd7e260908311900u3a4a02b9kd36156cfdce902c0@mail.gmail.com> <4A9FC81B.7020702@kernel.org> <4AA02F95.4050508@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41548 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932110AbZIDClq (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Sep 2009 22:41:46 -0400
In-Reply-To: <4AA02F95.4050508@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: Mike Hokenson <logan@gozer.org>, linux-ide@vger.kernel.org

Mark Lord wrote:
> I haven't really been following along.  But.. I have zero information
> here about the Marvell 6121 --> it's supposedly an AHCI chip, isn't it?

Here's the full thread.

 http://thread.gmane.org/gmane.linux.ide/42397
 http://thread.gmane.org/gmane.linux.ide/42568

> The device that's failing is an optical drive.  These often won't
> respond to many commands until the onboard firmware finishes
> examining whatever disc happens to be inserted, which can take
> longer than the time we normally allow.  I wonder if it has anything
> to do with that ?

I have no idea but Mike reports that it works just fine on ich9,
so....

Thanks.

-- 
tejun
