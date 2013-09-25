From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/6] PCI/MSI: Factor out pci_get_msi_cap() interface
Date: Wed, 25 Sep 2013 12:02:20 -0600
Message-ID: <20130925180220.GB26273@google.com>
References: <20130906160621.GF22763@mtj.dyndns.org>
 <20130906233205.GF12956@google.com>
 <20130909152044.GA24962@dhcp-26-207.brq.redhat.com>
 <20130916102210.GA14102@dhcp-26-207.brq.redhat.com>
 <20130917143022.GA7707@concordia>
 <20130918094759.GA2353@dhcp-26-207.brq.redhat.com>
 <20130918142231.GA21650@mtj.dyndns.org>
 <20130918165045.GB2353@dhcp-26-207.brq.redhat.com>
 <20130920082458.GA10507@dhcp-26-207.brq.redhat.com>
 <20130920122736.GD7630@mtj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ye0-f178.google.com ([209.85.213.178]:39223 "EHLO
	mail-ye0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061Ab3IYSC2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 25 Sep 2013 14:02:28 -0400
Received: by mail-ye0-f178.google.com with SMTP id m5so7605yen.23
        for <linux-ide@vger.kernel.org>; Wed, 25 Sep 2013 11:02:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130920122736.GD7630@mtj.dyndns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Alexander Gordeev <agordeev@redhat.com>, Michael Ellerman <michael@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Joerg Roedel <joro@8bytes.org>, Jan Beulich <JBeulich@suse.com>, linuxppc-dev@lists.ozlabs.org

On Fri, Sep 20, 2013 at 07:27:36AM -0500, Tejun Heo wrote:
> On Fri, Sep 20, 2013 at 10:24:59AM +0200, Alexander Gordeev wrote:
> > * Make pci_enable_msix() return 0/-errno
> 
> My choice would be this one.

I agree; it sounds like you've identified several bugs related to the
current confusing interface, so fixing that seems like the first step.

I hope we can avoid adding a plethora of interfaces to address unusual
corner cases.  But if we do the above and it turns out not to be enough,
we can always extend it later.

Bjorn
