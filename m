From: Pratyush Anand <pratyush.anand@st.com>
Subject: Re: [PATCH V3 5/8] ata: ahci platform: Add phy hooks to make it more
 generic
Date: Fri, 31 Jan 2014 09:22:16 +0530
Message-ID: <20140131035216.GB2618@pratyush-vbox>
References: <cover.1391077731.git.mohit.kumar@st.com>
 <f82b7b246b8bedb153de5d360638ce79f13d61f0.1391077731.git.mohit.kumar@st.com>
 <201401301406.14444.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:56183 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753609AbaAaDw3 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2014 22:52:29 -0500
Content-Disposition: inline
In-Reply-To: <201401301406.14444.arnd@arndb.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mohit KUMAR DCG <Mohit.KUMAR@st.com>, Tejun Heo <tj@kernel.org>, spear-devel <spear-devel@list.st.com>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Roger Quadros <rogerq@ti.com>

On Thu, Jan 30, 2014 at 09:06:14PM +0800, Arnd Bergmann wrote:
> On Thursday 30 January 2014, Mohit Kumar wrote:
> > From: Pratyush Anand <pratyush.anand@st.com>
> > 
> > Few platform does only phy specific work in platform callbacks. It is
> > better to use standard phy callbacks for such platform in stead of
> > platform callbacks.
> > 
> > This patch does not break any platform callbacks. It adds phy plugins
> > on top of that.
> > 
> > It has been assumed that no platform will need both phy plugins as well
> > as platform callbacks.
> > 
> > Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> > Cc: Mohit Kumar <mohit.kumar@st.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: spear-devel@list.st.com
> > Cc: linux-ide@vger.kernel.org
> 
> This patch looks good to me, but as I mentioned, there has
> been some related work recently. Please see the patch from
> Roger Quadros posted at http://lkml.org/lkml/2014/1/8/142

I am not subscribed to ide list and I did not see that patch :(.

Will test our platform with above patch.

Regards
Pratyush
> 
> One of the two should be enough.
> 
> 	Arnd
