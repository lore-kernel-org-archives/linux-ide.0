From: Tejun Heo <tj@kernel.org>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 16 Mar 2010 15:42:58 +0900
Message-ID: <4B9F2872.4060309@kernel.org>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de>	 <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>	 <4B9EED55.10201@kernel.org> <1268720060.21384.10.camel@mulgrave.site> <4B9F2388.2030803@kernel.org> <4B9F2746.3010105@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51947 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752763Ab0CPGnC (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 16 Mar 2010 02:43:02 -0400
In-Reply-To: <4B9F2746.3010105@earthlink.net>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Felix Miata <mrmazda@earthlink.net>
Cc: linux-ide@vger.kernel.org

Hello,

On 03/16/2010 03:37 PM, Felix Miata wrote:
> On 2010/03/16 15:22 (GMT+0900) Tejun Heo composed:
> 
>> Most BIOSs these days will simply report the geometry as
>> being 255/63 regardless of the geometry used during partitioning
> 
> In my experience this "most" only applies to desktop motherboard BIOS. Most
> laptop BIOS seem to prefer 240, as do many external USB HD case controllers,
> and older but not that antique Compaq desktops.

Hmmm... interesting, does that hold for modern laptops too?  It
doesn't really change the situation much tho.  It's just another
arbitrary geometry that BIOS reports that we can't really do much
about.

Thanks.

-- 
tejun
