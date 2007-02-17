From: "Eric D. Mudama" <edmudama@gmail.com>
Subject: Re: Implement the technote about promise/maxtor drives
Date: Sat, 17 Feb 2007 10:59:53 -0700
Message-ID: <311601c90702170959v74544d5cybb8feaa53033b9eb@mail.gmail.com>
References: <20070131171251.4210bcdb@localhost.localdomain>
	 <45D55003.6030307@tw.ibm.com> <45D55502.2020702@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:17390 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993005AbXBQR7z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 17 Feb 2007 12:59:55 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1910691nfa
        for <linux-ide@vger.kernel.org>; Sat, 17 Feb 2007 09:59:54 -0800 (PST)
In-Reply-To: <45D55502.2020702@tw.ibm.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: albertl@mail.com
Cc: Alan <alan@lxorguk.ukuu.org.uk>, jeff@garzik.org, linux-ide@vger.kernel.org, Mikael Pettersson <mikpe@it.uu.se>

On 2/15/07, Albert Lee <albertcc@tw.ibm.com> wrote:
> Some Maxtor drives have "Maxtor" and others have "MAXTOR" in the identify device data.
> If the slave is a "MAXTOR" one, the following code segment doesn't work.

The 6L drive is a design brought over from Maxtor's purchase of
Quantum, the 6Y is a Maxtor local design.

> Maybe we should check both "Maxtor" and "MAXTOR"?

It will have to... or maybe not...

Since I think Maxtor was the only vendor doing ATA133, maybe just
limit slave port on those adapters to UDMA100?  (Just checked newegg,
and Hitachi lists theirs as ATA133, while Samsung list theirs as
ATA133 compatible (default ATA100))

Were there enough other vendors doing ATA133 at the time the technote
was written to know if other brands were also affected?
