From: Tejun Heo <tj@kernel.org>
Subject: Re: System fails to connect to iHOS-104 DVD drive with nvidia MCP61
 chipset.
Date: Sun, 8 Sep 2013 08:25:49 -0400
Message-ID: <20130908122549.GA30549@htj.dyndns.org>
References: <520D92C6.30009@1045.ca>
 <520FB3BA.7050302@1045.ca>
 <CADLC3L27QcScLgw4CBGkQ3tG5037CAgQJRdW5384=sL8cM8a3Q@mail.gmail.com>
 <5217FFB2.4050007@1045.ca>
 <CADLC3L0wXmVDgHPOFEkeiXD9sDUBg3tZePcJ-gRfoRN5-fXE1w@mail.gmail.com>
 <52180F76.3070803@1045.ca>
 <CADLC3L2NfS7N30zqu5zPgxnh-vcEUxyWX3v4W1bUHB=G2J5m9Q@mail.gmail.com>
 <5218D74A.5020305@1045.ca>
 <522A62A1.6050904@1045.ca>
 <CADLC3L2uyJzz_4_q3tAUZ5+-wb2yqZ-r2LRzGCfPz6PN+1t8=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:41181 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab3IHMZx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 8 Sep 2013 08:25:53 -0400
Received: by mail-qc0-f181.google.com with SMTP id q4so2657741qcx.26
        for <linux-ide@vger.kernel.org>; Sun, 08 Sep 2013 05:25:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADLC3L2uyJzz_4_q3tAUZ5+-wb2yqZ-r2LRzGCfPz6PN+1t8=g@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Bruce Link <Bruce@1045.ca>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, 1063474@bugs.launchpad.net

Hello,

On Fri, Sep 06, 2013 at 07:53:49PM -0600, Robert Hancock wrote:
> > Is there any more information I can supply that would be helpful?
> 
> I'm not quite sure what the next step would be. It's quite possible
> that the NVIDIA driver in Windows is doing some magic to work around
> the problem that we don't know about, but it's hard to say what that
> might be. The fact that the default drivers used in the WinPE boot
> don't seem to work would tend to point toward some kind of hardware
> incompatibility issue.
> 
> Tejun, think you poked with some of this stuff before - any ideas?

It has been years since I looked at MCP quirks, of which there are too
many.  It's likely another quirk on the controller side that nvidia
worked around somehow without telling anyone.  Given the history and
that nvidia is out of chipset market, I think it's highly unlikely to
learn what the issue and workaround are without reverse engineering
it.  So, um, no idea.

Thanks.

-- 
tejun
