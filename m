From: Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH] libata: Pioneer DVR-216D can't do SETXFER
Date: Tue, 19 Apr 2011 18:06:20 -0400
Message-ID: <4DAE075C.5050707@suse.com>
References: <4DADA69C.4060708@suse.com> <4DADF903.5000503@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:60108 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184Ab1DSWGY (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Apr 2011 18:06:24 -0400
In-Reply-To: <4DADF903.5000503@ru.mvista.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jeff Garzik <jgarzik@redhat.com>, Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/19/2011 05:05 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 19-04-2011 19:13, Jeff Mahoney wrote:
> 
>>   Commit 4a5610a04d415ed94af75bb1159d2621d62c8328 fixed an issue with
> 
>    Please also specify that commit's summary in parens -- for the human
> readers.
> 
>>   the Pioneer DVR-212D not handling SETXFER correctly. An openSUSE user
>>   reported a similar issue with his DVR-216D that the NOSETXFER horkage
>>   worked around for him as well.
> 
>>   This patch adds the DVR-216D (1.08) to the horkage list for NOSETXFER.
> 
>>   The issue was reported at:
>>   https://bugzilla.novell.com/show_bug.cgi?id=679143
> 
>> Reported-by: Volodymyr Kyrychenko <vladimir.kirichenko@gmail.com>
>> Signed-off-by: Jeff Mahoney <jeffm@suse.com>

The issue and summary are identical except for the model number.

- -Jeff

- -- 
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk2uB1wACgkQLPWxlyuTD7Lk+ACfRWh9cqciafuYSCrTsA4/Ccci
aWcAniDuTUmJbbPGAYt6TKnQLzYiNQR5
=xpeL
-----END PGP SIGNATURE-----
