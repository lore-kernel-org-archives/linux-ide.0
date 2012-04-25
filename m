From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: Need Help for Apply Patch
Date: Wed, 25 Apr 2012 16:50:36 -0700
Message-ID: <4F988DCC.8030102@xenotime.net>
References: <897223386988143032@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from oproxy7-pub.bluehost.com ([67.222.55.9]:39671 "HELO
	oproxy7-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932459Ab2DYXuJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Apr 2012 19:50:09 -0400
In-Reply-To: <897223386988143032@unknownmsgid>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Tennyson <vijeycreative@gmail.com>
Cc: linux-ide@vger.kernel.org

On 04/25/2012 03:47 PM, Ben Tennyson wrote:

> From: Vijey
> Sent: 25/4/2012 5:30 PM
> To: tj@kernel.org
> Subject: Need Help for Apply Patch
> Hello Sir,
> I've recently installed Fedora 16 on my HP HDX 16 1050EE laptop.
> Whenever I leave my laptop to suspend, I get the devexch error and I
> came across your patch. "http://patchwork.ozlabs.org/patch/29840/" I'm
> just new to this operating system, so I couldn't apply the patch even
> with the help from other website. May you please write the patch command
> for me to apply the patch. In anticipation


Download the patch file from the URL that you quoted.

At the top level of your kernel source tree:

(this is one line:)

$ patch -p1 -b < /path/to/AHCI-connection-status-changed-hard-resetting-link-with-2.6.30.patch

then rebuild your kernel and install/boot it.

-- 
~Randy
