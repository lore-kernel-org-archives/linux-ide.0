From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/4] ahci: per-port msix support
Date: Fri, 30 Oct 2015 18:54:40 -0700
Message-ID: <CAPcyv4i+rpoebTGBn6yi=ExJUfcuZa5XiZz3c9OR=FKU66Zp1Q@mail.gmail.com>
References: <20151030210924.8538.90627.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20151030210940.8538.97829.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20151031010355.GD3582@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35200 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167AbbJaByl (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Oct 2015 21:54:41 -0400
Received: by wicll6 with SMTP id ll6so20701604wic.0
        for <linux-ide@vger.kernel.org>; Fri, 30 Oct 2015 18:54:40 -0700 (PDT)
In-Reply-To: <20151031010355.GD3582@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: IDE/ATA development list <linux-ide@vger.kernel.org>, Ricardo Neri <ricardo.neri@intel.com>

On Fri, Oct 30, 2015 at 6:03 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> Generally looks good to me.  One nitpick.
>
> On Fri, Oct 30, 2015 at 05:09:40PM -0400, Dan Williams wrote:
>> +     if (flags & AHCI_HFLAG_MULTI_MSIX) {
>> +             if (nvec < n_ports)
>> +                     return -ENODEV;
>> +             else
>> +                     nvec = min(nvec, n_ports);
>
> Maybe the following is easier?
>
>                 if (nvec < n_ports)
>                         return -ENODEV;
>
>                 nvec = n_ports;
>

Yeah, I missed that.  Will fix.
