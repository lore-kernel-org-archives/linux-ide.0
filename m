From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: gigabyte iRam not seen by linux
Date: Sat, 11 Mar 2006 09:12:25 -0700
Message-ID: <311601c90603110812t1f853d2ep333a2299fbb0d6b2@mail.gmail.com>
References: <20060310013604.1acac722.pegasus@nerv.eu.org>
	 <4411BCB6.5080108@gmail.com> <44122FBD.9000909@tw.ibm.com>
	 <20060311034630.4c12cf83.pegasus@nerv.eu.org>
	 <20060311033143.GA12866@htj.dyndns.org>
	 <20060311092013.487c1263.pegasus@nerv.eu.org>
	 <20060311085843.GA9067@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.180]:43393 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751214AbWCKQMZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 11 Mar 2006 11:12:25 -0500
Received: by pproxy.gmail.com with SMTP id s49so549118pyc
        for <linux-ide@vger.kernel.org>; Sat, 11 Mar 2006 08:12:25 -0800 (PST)
In-Reply-To: <20060311085843.GA9067@htj.dyndns.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: Jure Pe??ar <pegasus@nerv.eu.org>, linux-ide@vger.kernel.org, albertl@mail.com, jgarzik@pobox.com

On 3/11/06, Tejun Heo <htejun@gmail.com> wrote:
> Hello, again.
>
> It's reporting 0x00 for FEATURE when it should report 0x01 (indicates
> diagnostic passed).

Um, do you mean the error register?  Either way, yea, it would appear
that the device is reporting that it failed its own internal
diagnostics.
