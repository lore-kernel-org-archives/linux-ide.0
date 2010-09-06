From: Tejun Heo <tj@kernel.org>
Subject: Re: libata acpi issue on gateway laptop
Date: Mon, 06 Sep 2010 22:05:27 +0200
Message-ID: <4C854987.6070406@kernel.org>
References: <20100906193501.GM2684@bombadil.infradead.org> <4C854502.8040009@kernel.org> <20100906195108.GN2684@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54795 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274Ab0IFUFB (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 6 Sep 2010 16:05:01 -0400
In-Reply-To: <20100906195108.GN2684@bombadil.infradead.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kyle McMartin <kyle@mcmartin.ca>
Cc: jgarzik@redhat.com, linux-kernel@vger.kernel.org, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hello,

On 09/06/2010 09:51 PM, Kyle McMartin wrote:
> On Mon, Sep 06, 2010 at 09:46:10PM +0200, Tejun Heo wrote:
>> These are debug/info messages.  Just ignore them.
>>
> 
> The user claims they are causing long delays waiting for the timeouts to
> occur that go away if booting with noacpi...

Hmm... I don't see any timeout in the log you posted.  Ah, okay, the
interesting part is in the full log, the ACPI GTF sequence itself is
finishing fine but the next NCQ READ command is timing out.  The BIOS
is enabling non-zero buffer offsets and DMA setup FIS auto-activate.
It's likely that the controller isn't being configured correctly
leading to mismatch between the behavior expected by the controller
and the actual drive behavior.  Hmm.... I'll look further into it
tomorrow.  For the record, can you please attach the full log, lspci
-nn output and dmidecode output here?

Thanks.

-- 
tejun
