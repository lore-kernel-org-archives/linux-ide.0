From: "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: iq81340mc: oops with SATA VIA
Date: Wed, 7 Mar 2007 12:41:48 -0700
Message-ID: <e9c3a7c20703071141n2b01a4d4i356545b740c24679@mail.gmail.com>
References: <20070212114114.GG6457@deprecation.cyrius.com>
	 <0C7297FA1D2D244A9C7F6959C0BF1E52017D0497@azsmsx413.amr.corp.intel.com>
	 <20070307011443.08a13916@lxorguk.ukuu.org.uk>
	 <e9c3a7c20703061923y3d2fd9c7pdf323b94569f42c3@mail.gmail.com>
	 <20070307123956.GI13384@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:5196 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992505AbXCGTlu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Mar 2007 14:41:50 -0500
Received: by nf-out-0910.google.com with SMTP id o25so324845nfa
        for <linux-ide@vger.kernel.org>; Wed, 07 Mar 2007 11:41:49 -0800 (PST)
In-Reply-To: <20070307123956.GI13384@deprecation.cyrius.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Martin Michlmayr <tbm@cyrius.com>
Cc: buytenh@wantstofly.org, linux-ide@vger.kernel.org

On 3/7/07, Martin Michlmayr <tbm@cyrius.com> wrote:
> * Dan Williams <dan.j.williams@intel.com> [2007-03-06 20:23]:
> > Martin can you give the attached patch a try to see if it resolves the
> > oops?  It has only been compile tested.  The patch spins the processor
> > on the ATU outbound-queue-busy bit whenever out*() is called.
>
> Nope, that doesn't seem to work:
>
Ok, this actually makes sense because the hardware will not allow
delayed writes to pass each other.  The patch would only help in the
case where ordering between posted and delayed writes needed to be
maintained, and it looks like sata_via only exposes a delayed write
interface.  I'll put together a patch to dump more diagnostics on an
external abort.
