From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] sata_nv: sgpio for nvidia mcp55 -v2
Date: Thu, 22 Jan 2009 09:26:01 -0800
Message-ID: <4978AC29.8080308@kernel.org>
References: <20061031104055.GA8898@infradead.org>    <15F501D1A78BD343BE8F4D8DB854566B0C8DDCF5@hkemmail01.nvidia.com>    <86802c440711062009t7e98d27fqdfb466b9843da060@mail.gmail.com>    <86802c440901180120u3e60e73dm53a37b7cd9034915@mail.gmail.com>    <4972F4E5.3030203@kernel.org> <49768355.4040301@kernel.org>    <49773189.6050009@seiner.com> <49776DFB.8090506@kernel.org>    <4977FA12.6050103@seiner.com> <4977FF09.50808@kernel.org> <a20f505b0186b360ea9eecefba08aceb.squirrel@www.datavault.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49966 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbZAVR0b (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 22 Jan 2009 12:26:31 -0500
In-Reply-To: <a20f505b0186b360ea9eecefba08aceb.squirrel@www.datavault.us>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Yan Seiner <yan@seiner.com>
Cc: Peer Chen <pchen@nvidia.com>, linux-ide@vger.kernel.org

Yan Seiner wrote:
> On Wed, January 21, 2009 9:07 pm, Yinghai Lu wrote:
>> please try -v3 and boot with debug in command line, then post bootlog.
> 
> Dumb question:
> 
> Where does the debug parameter go?  Kernel command line?

in your /boot/grub/grub.conf
every boot entry will have append line to let you add some boot parameter. add "debug" in those line, and remove quiet etc.

YH
