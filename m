From: Tejun Heo <tj@kernel.org>
Subject: Re: Working around bogus HPAs in libata
Date: Tue, 06 Apr 2010 11:33:39 +0900
Message-ID: <4BBA9D83.2040909@kernel.org>
References: <1269192318.18314.218.camel@localhost>	 <4BB5637E.4050604@kernel.org> <1270245450.12516.187.camel@localhost>	 <4BBA95F8.7070909@kernel.org> <1270520930.24287.102.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60724 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756870Ab0DFCeZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 5 Apr 2010 22:34:25 -0400
In-Reply-To: <1270520930.24287.102.camel@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-ide@vger.kernel.org, debian-kernel@lists.debian.org

Hello,

On 04/06/2010 11:28 AM, Ben Hutchings wrote:
> If a system vendor puts its own name or model numbers on the disks it
> ships then I think the BIOS or other platform firmware can reasonably
> assume that it 'owns' and can write to the HPA on a disk with the
> vendor's identification.  (I wouldn't be at all surprised to find that
> some vendors take shortcuts though.)

I would be very surprised if no vendor took shortcuts.  :-)

>> Ah... I see, but let's fix that up too.  It could be worse to have
>> half working workaround than not working around at all.  I'll update
>> the patch once the currently pending HPA updates are in.
> 
> Oh, what are those?

The patch I posted is rolled up version which contained currently
pending HPA unlock on shrink patch.

  http://article.gmane.org/gmane.linux.ide/45662

> I want to apply some version of this fix in Debian soon so we can
> complete the transition to libata.  I would very much appreciate it if
> you could answer whether or not the multiple 'capacity change' messages
> may indicate a problem.

Multiple messages are probably sd doing revalidation of the device.  I
don't think it will cause any problem but I'll look into it later
today and let you know.

Thanks.

-- 
tejun
