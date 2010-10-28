From: Siddhartha Jain <siddhartha@siddharthajain.net>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Wed, 27 Oct 2010 19:11:05 -0700
Message-ID: <AANLkTikBiCwCmCp-RgWBDb6nwkifK2CuiUXVSXYpMaCK@mail.gmail.com>
References: <1283027290.2721.37.camel@myfedorahat>
	<4C7BAA42.2050809@kernel.org>
	<AANLkTimEQEAF7WfCmmSfS_Ryq7HEfqemAnh9BvdKRhqL@mail.gmail.com>
	<AANLkTi=3BVGUSNUZn=QbDciWdhBPmxe0kQgKcBFtkSH7@mail.gmail.com>
	<AANLkTin5uTJA0G+hWxfsGFhyC_N9ZR7rZN9qCjK5VyvU@mail.gmail.com>
	<AANLkTi=mGaNoutyh=iVrGORYjRx_qvnVfMHL63TuY5gY@mail.gmail.com>
	<AANLkTikqxmzQozCOo+7XDSWE4tTniSnYbomEgqA4aB-2@mail.gmail.com>
	<4C7F77C4.6040404@kernel.org>
	<AANLkTi=_fmtNjj=ZeSyuMtQg+YBJ3=gHAkeurJhDZmmh@mail.gmail.com>
	<4C80BA34.7090400@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43964 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757995Ab0J1CLH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Oct 2010 22:11:07 -0400
Received: by qwf7 with SMTP id 7so648404qwf.19
        for <linux-ide@vger.kernel.org>; Wed, 27 Oct 2010 19:11:05 -0700 (PDT)
In-Reply-To: <4C80BA34.7090400@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

Just wanted to checkin and report that so far I applied the patch to
two revisions of 2.6.34 from fedora 13 x64 and have had no issues. My
macbook pro sleeps well and wakes up as normal everytime.

Thanks again to all involved. When should I expect it to be updated in
the main trunk?



On 9/3/10, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On 09/02/2010 09:56 PM, Siddhartha Jain wrote:
>> Applied patch to 2.6.35.4. Patched cleanly and kernel compile was smooth.
>>
>> Suspend works beautifully now. Not only does the system resume
>> properly but earlier suspend would take minutes, now it goes to
>> suspend within seconds (less than 10).
>>
>> I will re-build my laptop with dmcrypt + ext4, apply this patch and
>> use the system for a while to ensure all play together nicely.
>>
>> Thanks Tejun!! Really appreciate the quick turnaround on this issue. I
>> saved debugging info from the successful resume where I have debugging
>> turned on for various modules - acpi, pci etc. Let me know if you need
>> me to send it across.
>
> Debugging was mostly done by Rafael, so he deserves most of credit.
> Can you please keep testing for a few more days and let me know the
> result?
>
> Thanks.
>
> --
> tejun
>


-- 
- Siddhartha
  WV6U
