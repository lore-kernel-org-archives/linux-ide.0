Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2470A377EB9
	for <linux-ide@vger.kernel.org>; Thu, 23 Apr 2026 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961039; cv=none; b=St99RLCssixYaxKR7Qxc0SamQLeI2rSAa0Jvnl7O6A99VZEyRNMXWIGnEZplTyvQtQOefaJVtyD0t5F9afywri/5yvYN25oDQr3erqPMnKtk2MCJ5PPib1G2SsHoNcoQw807I6IudA1ZpdunZpPpxpq1LbDMoUVdqttyhj4CgwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961039; c=relaxed/simple;
	bh=teQQGU1qUokgg8fXjpgeal63LuanB0YesvRr+OOBf8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYMdwFQvH2xpH+kFBDOeTkYRBfI075Vu9dstnvtMgnY6UN/3NEDRZGGz3mPh8e1eEklTNKKY94BHfWNnwN8ZkI7EawzQossCf1Lvl2Zwj5mr+Z664T+Oo6gAGdxRyF4gXNEvJJxO3kVTDWYggJajxug8ZpiYLs1yhjscuTvUngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/WyAz2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/WyAz2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21688C2BCAF;
	Thu, 23 Apr 2026 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776961038;
	bh=teQQGU1qUokgg8fXjpgeal63LuanB0YesvRr+OOBf8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/WyAz2ObjKUdR9rT1/0AxiJcLAlXOHfVFuR5IsvJZ/LlCRviUzB+QUo0XGmViWqB
	 15KuSVeavMbeJS/USafYqC3W0ARO0uGjaQlRmuTeVP1HXbz6OttV5t2tmvR6aIokOL
	 2Ur5g9Ucl1Rt+RnG68H+OKwc8lZi1VhO+suLLlovk5AxJ6Kb/UtgL8Ej61xehIpMeF
	 RuyPILAahyZpepfr6IP0zNiFjMibMkC26YGelanGYcBGVUguoe1a3OGzG0sCw9Q7eD
	 v9nbGaP62MuBAhSRtkkMh2va8Mz5bEMs6daC8I8iVpy7GYSAyk64sO9ICHvm3yUFr4
	 XR/PUYTGRQ0DA==
Date: Thu, 23 Apr 2026 18:17:15 +0200
From: Niklas Cassel <cassel@kernel.org>
To: AlanCui4080 <me@alancui.cc>
Cc: linux-ide@vger.kernel.org
Subject: Re: Default IDENTIFY timeout is 5000ms which is too short for
 enterprise disks
Message-ID: <aepGCyy5uXXxw6jT@ryzen>
References: <14015677.uLZWGnKmhe@alanarchdesktop>
 <f8dAJyMVQ4yJA5_7X9Jscw@alancui.cc>
 <aen_SQ-7fPfdAylr@ryzen>
 <p9jLdz6RRGKjgu3OloMgWw@alancui.cc>
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p9jLdz6RRGKjgu3OloMgWw@alancui.cc>

Hello Alan,

On Thu, Apr 23, 2026 at 10:26:55PM +0800, AlanCui4080 wrote:
> Thank you for your really really detailed response. And i was surprised by your
> reply, hopefully that doesn't cost your time too much.

My pleasure :)


> I'm not a native speaker so the actually question that i want to ask is that
> will kernel do quirk for those drives so let it just don't fail to avoid costing
> extra 5 seconds and producing annoying erros on console?

Well, considering that the controller does not send a reply when it is
supposed to, I think that the error in the log is justified.


You also wrote that:
> I enlong the timeout, then this problem is being "relaxed", during 10
> recoveries, only 2 times the revalidation failed.

So as far as I can tell, even increasing the timeout does not solve the
problem in all cases.

So, right now, I can't even think of a way to quirk the device so that it
works reliably.


> > But as soon as you get a shell after a system resume, the above command
> > succeeds, right?
> 
> Yes, that's correct.

Great!


> > My suggestion is to look at the zpool code to see how long it waits to finds
> > all devices after a system resume before it kicks devices off the RAID array.
> > 
> > My initial feeling is that if your device is ready after 5 seconds after a
> > system resume, then the timeout value for zpool to kick off a device must be
> > very low.
> 
> I do believe that's about zpool, i migrated it into btrfs RAID now, it works very
> well. And if you want to know, the timeout of TXG to commit is 5000ms also.

Nice to hear that you are not seeing the same issue with btrfs.


Kind regards,
Niklas
