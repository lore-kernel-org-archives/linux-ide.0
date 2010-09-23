From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: pata_it821x driver reports many FLUSH CACHE command failures
Date: Fri, 24 Sep 2010 00:43:43 +0100
Message-ID: <20100924004343.0abebfad@lxorguk.ukuu.org.uk>
References: <20100923172724.0da07fb1@katamari>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54705 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753413Ab0IWXUy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 23 Sep 2010 19:20:54 -0400
In-Reply-To: <20100923172724.0da07fb1@katamari>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 23 Sep 2010 17:27:24 -0400
Chuck Ebbert <cebbert@redhat.com> wrote:

> It looks like pata_it821x has never supported FLUSH_CACHE, but now

That depends on the firmware you have I believe

The ident it provides also doesn't advertise flush cache so something
appears to be issuing a cache flush despite the drive reporting that it
is not supported.

> we're seeing repeated failures. They happen over and over again and
> prevent installation. I stuck a dump_stack() in the failure path and
> got this:

Yes you'll crash some firmware versions if this occurs.

See:

static unsigned int it821x_read_id(struct ata_device *adev,
                                        struct ata_taskfile *tf, u16 *id)


If this has stopped working then you probably want to get Jeff to trace
back into the ATA and SCSI midlayer to see why it is issuing flushes for
a device which is reporting that cache flush is not supported - because
that is seriously broken.


