From: "Jan Beulich" <JBeulich@suse.com>
Subject: regarding your patch "AHCI: Support multiple MSIs"
Date: Wed, 10 Apr 2013 16:05:30 +0100
Message-ID: <51659BDA02000078000CC288@nat28.tlf.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:42010 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765111Ab3DJPFd convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-linux-ide@vger.kernel.org:3:1>);
	Wed, 10 Apr 2013 11:05:33 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: agordeev@redhat.com
Cc: mingo@elte.hu, jgarzik@redhat.com, linux-ide@vger.kernel.org

Alexander,

I'm a bit puzzled by the way ahci_init_interrupts() works, when
looking at a particular hardware implementation having 6 ports
but allowing up to 16 MSIs - obviously, with one IRQ per port,
obtaining 8 MSIs would be sufficient in this case, conserving on
resources. Is there any reason this can't be done (i.e. by the
caller of pci_enable_msi_block_auto() passing in the maximum
desired number)?

Besides that, would it be possible to tweak things so that
/proc/interrupts could show distinct names for the individual
IRQs?

Thanks, Jan

