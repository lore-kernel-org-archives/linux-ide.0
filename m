From: Tejun Heo <tj@kernel.org>
Subject: Re: Sil 3124: "softreset failed (SRST command error)"
Date: Tue, 12 Oct 2010 15:45:03 +0200
Message-ID: <4CB4665F.5030207@kernel.org>
References: <i8vbcg$4hc$1@dough.gmane.org> <i8vq15$biu$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51903 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724Ab0JLNpH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 12 Oct 2010 09:45:07 -0400
In-Reply-To: <i8vq15$biu$1@dough.gmane.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeremy Sanders <jeremy@jeremysanders.net>
Cc: linux-ide@vger.kernel.org

On 10/11/2010 09:54 PM, Jeremy Sanders wrote:
> Jeremy Sanders wrote:
> 
>> Hi - I'm having problems getting a Sil 3124 card with a PCI-Express 1x
>> interface to work, see https://bugzilla.redhat.com/show_bug.cgi?id=641878
>> Here is the card:
>>  http://www.era-adapter.com/pciexpress-1x-to-4-ports-sata-ii-adapter-
> p-60.html
> 
> I've now tried building the latest git module which doesn't work. I've tired 
> commenting out the pcie_set_readrq(pdev, 4096) line - no luck. I've tried 
> enabling MSI interrupts - it gets an MSI interrupt but fails in the same 
> way. I've also tried disabling hard and soft resets - though it fails later 
> in the initialization.

Have you tried a different drive?

-- 
tejun
