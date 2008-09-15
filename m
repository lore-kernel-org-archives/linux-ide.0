From: "Shem Multinymous" <multinymous@gmail.com>
Subject: Re: Laptop shock detection and harddisk protection
Date: Mon, 15 Sep 2008 14:09:39 -0400
Message-ID: <41840b750809151109o62111f65w51ca0e7b036ca3a@mail.gmail.com>
References: <48C7FCEE.8060404@kernel.org>
	 <41840b750809110908o54a61f55w7b1b9793abf55634@mail.gmail.com>
	 <48C948A6.3080404@kernel.org>
	 <41840b750809111325t30f8ffe2sa4572d401d43dc5a@mail.gmail.com>
	 <48C9AB5A.705@kernel.org> <20080912165947.GB5094@kroah.com>
	 <48CE1CE8.502@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:5681 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbYIOSJk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 15 Sep 2008 14:09:40 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2143569wfd.4
        for <linux-ide@vger.kernel.org>; Mon, 15 Sep 2008 11:09:39 -0700 (PDT)
In-Reply-To: <48CE1CE8.502@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Greg KH <greg@kroah.com>, Elias Oltmanns <eo@nebensachen.de>, Thomas Renninger <trenn@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, IDE/ATA development list <linux-ide@vger.kernel.org>

Hi,

On Mon, Sep 15, 2008 at 4:29 AM, Tejun Heo <tj@kernel.org> wrote:
>> Sorry, but no, I can't accept this code as it is coming from a "known
>> anonymous" person containing information that it is not known where it
>> came from.
>>
>> We went over this before a number of years ago, that's why this code
>> isn't in mainline :(
>
> Shem Multinymous, I suppose nothing really has changd since the last
> time?

The only pertinent change is that I've added even more documentation
to thinkpad_ec.c, explaining how we're just following the published
H8S specs (plus some workarounds for experimentally observed bugs).

As noted before, I'd be more than happy to assign away copyrights or
discuss things further in private if this would help.

  Shem
