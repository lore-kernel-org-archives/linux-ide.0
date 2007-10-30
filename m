From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: SATA_SIL
Date: Tue, 30 Oct 2007 18:58:04 -0400
Message-ID: <87f94c370710301558u126bb86p526b19004ccadabe@mail.gmail.com>
References: <1193781389.26314.9.camel@ws1.fransdb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.230]:33094 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbXJ3W6H (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 30 Oct 2007 18:58:07 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1232930wra
        for <linux-ide@vger.kernel.org>; Tue, 30 Oct 2007 15:58:04 -0700 (PDT)
In-Reply-To: <1193781389.26314.9.camel@ws1.fransdb.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans de Boer <frans@fransdb.nl>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

On 10/30/07, Frans de Boer <frans@fransdb.nl> wrote:
> Dear Sir,
>
> I know, I am not the only one to find out that we can't upgrade to a
> newer kernel when using SUSE 10.3. It seems that in 2.6.23 the sil
> modules have been updated (newer versions) and thus render the current
> system mostly unuseable. I noticed that in the sata_sil24.c source there
> where a significant number of chances, which are probally not easy to
> change. Overwriting the newer versions with the versions from 2.6.22.9
> might work, but for how long.
>
> Is this a problem SUSE introduced, you forgot to take legacy into
> account or is it a "feature".
> Is this problem adjusted in 2.6.24-rc1?
>
> Kind regards,
> Frans de Boer.

Did you try a SUSE factory kernel or a kotd (kernel of the day,
2.6.23.1 based currently)

You can find the kotd kernels on thier mirrors.

ie. ftp://suse.mirrors.tds.net/pub/projects/kernel/kotd/HEAD is in the US.

I don't know if they have released 2.6.23 factory kernels yet.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
