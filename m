From: Felix Miata <mrmazda@earthlink.net>
Subject: Re: ATA 4 KiB sector issues.
Date: Tue, 16 Mar 2010 02:37:58 -0400
Message-ID: <4B9F2746.3010105@earthlink.net>
References: <4B947393.2050002@kernel.org> <201003100046.24695.arnd@arndb.de>	 <1158166a1003100114j6ea329fbh84bfad65dcac90bf@mail.gmail.com>	 <4B9EED55.10201@kernel.org> <1268720060.21384.10.camel@mulgrave.site> <4B9F2388.2030803@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pop-satin.atl.sa.earthlink.net ([207.69.195.63]:41152 "EHLO
	pop-satin.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966003Ab0CPGhe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Mar 2010 02:37:34 -0400
Received: from user-142grkd.cable.mindspring.com ([72.40.110.141] helo=[192.168.0.51])
	by pop-satin.atl.sa.earthlink.net with esmtp (Exim 3.36 #1)
	id 1NrQPF-0003xz-00
	for linux-ide@vger.kernel.org; Tue, 16 Mar 2010 02:37:33 -0400
In-Reply-To: <4B9F2388.2030803@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 2010/03/16 15:22 (GMT+0900) Tejun Heo composed:

> Most BIOSs these days will simply report the geometry as
> being 255/63 regardless of the geometry used during partitioning

In my experience this "most" only applies to desktop motherboard BIOS. Most
laptop BIOS seem to prefer 240, as do many external USB HD case controllers,
and older but not that antique Compaq desktops.
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409

Felix Miata  ***  http://fm.no-ip.com/
