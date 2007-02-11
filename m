From: Tejun Heo <htejun@gmail.com>
Subject: Re: Status of Hotplug polling patches?
Date: Sun, 11 Feb 2007 00:38:35 -0500
Message-ID: <45CEABDB.1010004@gmail.com>
References: <45CE7F8D.60507@overt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.230]:15595 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbXBKFi6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Feb 2007 00:38:58 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1247094nze
        for <linux-ide@vger.kernel.org>; Sat, 10 Feb 2007 21:38:57 -0800 (PST)
In-Reply-To: <45CE7F8D.60507@overt.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Philip Langdale <philipl@overt.org>
Cc: linux-ide@vger.kernel.org

Philip Langdale wrote:
> Hi TeJun,
> 
> I have a machine that I've been using 2.6.19 and your hotplug
> polling patches on with great success and I just upgraded it
> to 2.6.20 and it appears that getting those patches working
> again will be non-trivial. As far as I can see, these patches
> are not in Jeff's tree or even yours. Have they been discarded,
> or am I looking in the wrong place? I certainly don't see
> equivalent functionality in the current kernel.
> 
> The warmplug sysfs-foo isn't particularly inconvenient as I
> need to explicitly unmount filesystems anyway, but it would
> be nice to see hotplug working again.
> 
> (The machine is using an nvidia mcp55)

To turn it on and off libata needs per-dev sysfs interface which it 
currently doesn't have.  This is on to-do list as PMP support needs it too.

-- 
tejun
