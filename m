From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 5/8] ata: ahci platform: Add phy hooks to make it more generic
Date: Thu, 30 Jan 2014 14:06:14 +0100
Message-ID: <201401301406.14444.arnd@arndb.de>
References: <cover.1391077731.git.mohit.kumar@st.com> <f82b7b246b8bedb153de5d360638ce79f13d61f0.1391077731.git.mohit.kumar@st.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62082 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbaA3NG1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Jan 2014 08:06:27 -0500
In-Reply-To: <f82b7b246b8bedb153de5d360638ce79f13d61f0.1391077731.git.mohit.kumar@st.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mohit Kumar <mohit.kumar@st.com>
Cc: Pratyush Anand <pratyush.anand@st.com>, Tejun Heo <tj@kernel.org>, spear-devel@list.st.com, linux-ide@vger.kernel.org, Roger Quadros <rogerq@ti.com>

On Thursday 30 January 2014, Mohit Kumar wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
> 
> Few platform does only phy specific work in platform callbacks. It is
> better to use standard phy callbacks for such platform in stead of
> platform callbacks.
> 
> This patch does not break any platform callbacks. It adds phy plugins
> on top of that.
> 
> It has been assumed that no platform will need both phy plugins as well
> as platform callbacks.
> 
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Cc: Mohit Kumar <mohit.kumar@st.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: spear-devel@list.st.com
> Cc: linux-ide@vger.kernel.org

This patch looks good to me, but as I mentioned, there has
been some related work recently. Please see the patch from
Roger Quadros posted at http://lkml.org/lkml/2014/1/8/142

One of the two should be enough.

	Arnd
