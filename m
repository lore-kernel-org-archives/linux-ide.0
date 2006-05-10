From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH -mm] sata_vsc gcc 4.1 warning fix
Date: Wed, 10 May 2006 13:20:44 +0900
Message-ID: <44616A1C.20800@gmail.com>
References: <200605100256.k4A2u6Hu031761@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964794AbWEJEUu@vger.kernel.org>
In-Reply-To: <200605100256.k4A2u6Hu031761@dwalker1.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, jeremy@sgi.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

Daniel Walker wrote:
> Fixes the following warning,
> 
> drivers/scsi/sata_vsc.c:152: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:153: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:154: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:155: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:156: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:158: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:159: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:160: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:161: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:162: warning: passing argument 2 of 'writew' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:166: warning: passing argument 2 of 'writeb' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c: In function 'vsc_sata_tf_read':
> drivers/scsi/sata_vsc.c:178: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:179: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:180: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:181: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:182: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:183: warning: passing argument 1 of 'readw' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c: In function 'vsc_sata_setup_port':
> drivers/scsi/sata_vsc.c:320: warning: passing argument 2 of 'writel' makes pointer from integer without a cast
> drivers/scsi/sata_vsc.c:321: warning: passing argument 2 of 'writel' makes pointer from integer without a cast
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
> 

Hello, Daniel.

This fix comes up every so often and I have submitted almost identical 
patch several months ago.  Unfortunately, it's not the proper fix and 
won't be accepted.  All those read/writeX()'s and in/outX()'s are 
scheduled (for a looooong time) to be converted to new unified 
ioread/writeX()'s.  Things are in progress (well, or halt) in the #iomap 
branch of libata-dev devel tree.  libata needs some updates in host 
initialization part for this conversion to complete.

Thanks.

-- 
tejun
