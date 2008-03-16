From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC] Read/Write Buffer support
Date: Sat, 15 Mar 2008 18:46:09 -0600
Message-ID: <20080316004609.GZ613@parisc-linux.org>
References: <20080315153730.GX613@parisc-linux.org> <47DC04CD.7060209@garzik.org> <20080315174929.GY613@parisc-linux.org> <47DC5223.6080105@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:52601 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbYCPAq0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Mar 2008 20:46:26 -0400
Content-Disposition: inline
In-Reply-To: <47DC5223.6080105@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

On Sat, Mar 15, 2008 at 06:48:03PM -0400, Jeff Garzik wrote:
> You arrived at the proper conclusion -- it doesn't happen in practice 
> for a variety of reasons, the main one being that it's largely in the 
> realm of something the superuser must do intentionally, the way kernel 
> and userland code is written today.

I think it could easily happen accidentally.  In any case, it's worth
fxing.

> Thus, the code intentionally avoids the silly complexity for a case that 
> never truly happens outside of synthetic superuser experiments.
> 
> Remember, this and all the other code originated in the days of "if 
> (use_sg)", when scatterlists were not used often for !(read|write) commands.

I have no desire to increase the complexity of libata, but I think it's
possible to fix this in a couple of different ways without adding extra
complexity.

One possible way would be for simulate to allocate a page and pass that
into the actor functions to fill in.  Then simulate could copy that page
into the sg lists.  This doesn't fix my problem where I need to
part-simulate, part-translate, but it's a possible solution for all the
various inquiries.

Another would be for the actor functions to set up their own buffers and
call something similar to the copy_buffer() function I had as part of
the scsi_ram driver I wrote.  I happened to write it for the use of
INQUIRY too ;-)

+static void copy_buffer(struct scsi_cmnd *cmnd, char *buf, int len)
+{
+       char *p;
+       struct scatterlist *sg;
+       int i;
+
+       scsi_for_each_sg(cmnd, sg, scsi_sg_count(cmnd), i) {
+               int tocopy = sg->length;
+               if (tocopy > len)
+                       tocopy = len;
+
+               p = kmap_atomic(sg_page(sg), KM_USER0);
+               memcpy(p + sg->offset, buf, tocopy);
+               kunmap_atomic(p, KM_USER0);
+
+               len -= tocopy;
+               if (!len)
+                       break;
+               buf += tocopy;
+       }
+
+       scsi_set_resid(cmnd, len);
+}

> P.S.  I encourage others to investigate making the libata SCSI simulator 
> an optional kernel module.
> 
> Long term, a preferred solution would be to use SCSI layer for ATAPI 
> devices, and a kernel block device for ATA devices.

I think that's the right method to take, though we probably still want
to emulate the scsi ioctls.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
