From: Tejun Heo <htejun@gmail.com>
Subject: Re: Loading both the pata_atiixp and the ahci driver causes problems
Date: Sun, 18 Mar 2007 15:38:43 +0900
Message-ID: <45FCDE73.8090002@gmail.com>
References: <45F9C3F5.4070906@redhat.com> <45F9F5F0.3090508@jonmasters.org> <45FCD0FB.70507@gmail.com> <45FCDBFA.702@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:40117 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbXCRGiv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 18 Mar 2007 02:38:51 -0400
Received: by nz-out-0506.google.com with SMTP id s1so458323nze
        for <linux-ide@vger.kernel.org>; Sat, 17 Mar 2007 23:38:50 -0700 (PDT)
In-Reply-To: <45FCDBFA.702@jonmasters.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jon Masters <jonathan@jonmasters.org>
Cc: Chuck Ebbert <cebbert@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org, Conke Hu <conke.hu@gmail.com>

Hello, Jon.

Jon Masters wrote:
>> Dunno much about sb600 but ahci and pata_atiixp are probably using
>> separate IO regions && separate PCI functions.
> 
> Yeah. I actually thought about this whole issue a bit more recently -
> things like SATA/PATA interference when you've got a part that emulates
> legacy functionality so can appear as two different kinds of device -
> since I don't think my brain was really bothering to listen before.
> Words were going in, but it chose to ignore what was being said.

Dunno about the history.  Oh well, as long as the problem gets fixed.

> Only thing that comes to mind is in-driver logic/driver loading ordering
> hack combinations. At least if you've got loadable modules, you've got a
> fighting chance of fixing this kind of situation - built-in and you need
> to fight with whatever ordering exists in the array of init functions.

Not sure whether it applies to sb600 directly but libata policy for this
type of situation is..

* always prefer the native / more capable (read ahci) interface over
emulated SFF interface.

* program the device and update PCI header using a PCI quirk such that
module loading order or BIOS setting doesn't affect which driver gets
attached.  Note that if the controller needs to programmed in specific
way, the quirk also needs to be called during resume.  In this case, the
function for SFF interface can simply be disabled.

Please take a look at the JMB quirk in drivers/pci/quirks.c in the
latest libata-dev#upstream tree for details.

Thanks.

-- 
tejun
