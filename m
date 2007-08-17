From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] advertise correct IDE mode on Pegasos2
Date: Fri, 17 Aug 2007 20:30:13 +0200
Message-ID: <20070817183013.GA769@aepfle.de>
References: <20070404111635.GA1855@aepfle.de> <20070817131048.GA31192@aepfle.de> <20070817143311.GA32390@aepfle.de> <46C5E6B9.6080408@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:47269 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbXHQSaA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 17 Aug 2007 14:30:00 -0400
Content-Disposition: inline
In-Reply-To: <46C5E6B9.6080408@genesi-usa.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matt Sealey <matt@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org

On Fri, Aug 17, Matt Sealey wrote:

> Setting them to ~0x5 will set them to 0 (legacy mode) and they will always 
> read
> back as 0 (legacy mode.. sigh) even if in native mode.

The pci_dev->class needs updating as well, see second version of the
patch.
