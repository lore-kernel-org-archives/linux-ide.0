From: Francois Payette <francoisp@netmosphere.net>
Subject: Re: SATA150TX4 atat1:command timeout
Date: Wed, 16 Feb 2005 10:04:13 -0500
Message-ID: <421360ED.2040505@netmosphere.net>
References: <42111B02.4010805@netmosphere.net> <4211279C.5070205@pobox.com>
Reply-To: francoisp@netmosphere.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from 65.18.135.ptr ([65.18.135.81]:64151 "EHLO isecurit.com")
	by vger.kernel.org with ESMTP id S262038AbVBPPDh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Feb 2005 10:03:37 -0500
In-Reply-To: <4211279C.5070205@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

With plain vanilla 2.6.11-rc4 the same bug appears after about 250GB 
(avg of 2 trials). With the TBG clock setting line omitted it still 
happens, but after about 1 1 TB (avg of 2 trials, takes about 6hrs per 
trial). Interestingly enough, this change does not slow down the setup, 
it even seems a little faster.

I was mistaken earlier: the 4 drives are not exactly the same, there is 
2 6B200M0 one 6B200S0 and one 6Y200M0. This should be irrelevant as I 
have swapped disks and wires and the problem happens anyway. One 
interesting thing: in init 1 the timeout seems to appear faster, after 
about 200GB in the case with the omission. I would be inclined to think 
this is some sort of a deadlock or race condition: the kernel does not 
dump or panic, it just hangs on pdc_eng_timeout. When we dumped the 
stack  in that function, all we had was pdc_eng_timeout, as there seems 
to a be a separate thread per disk that gets waken up for error handling.

Any ideas on how we can catch this one?
TIA,
Francois
