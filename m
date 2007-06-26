From: Frederik Himpe <fhimpe@telenet.be>
Subject: Re: [2.6.22-rc6] NForce4 soft and hard resetting ports and
 exceptions
Date: Tue, 26 Jun 2007 18:54:37 +0000 (UTC)
Message-ID: <pan.2007.06.26.18.54.37@telenet.be>
References: <pan.2007.06.26.17.45.21@telenet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759132AbXFZSzg@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

On Tue, 26 Jun 2007 17:45:22 +0000, Frederik Himpe wrote:

> I tried Linux 2.6.22-rc6 on my machine with an Asus A8N-SlI Deluxe
> motherboard (NForce 4 chipset).
> 
> When booting, the system hangs for a long time, but it continues after a
> long wait. I found these kind of errors in the logs afterwards:

[...]

> With Linux 2.6.21 this did not happen.
> 
> config, dmesg and lspci can be found here:
> http://artipc10.vub.ac.be/kernelbug/

After disabling hddtemp and smartd services, these errors do not happen 
anymore.

-- 
Frederik
