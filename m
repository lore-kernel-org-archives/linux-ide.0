From: viresh kumar <viresh.kumar@st.com>
Subject: Re: [PATCH Resend] ATA: Debugging options for the ATA subsystem
Date: Tue, 26 Jul 2011 09:23:02 +0530
Message-ID: <4E2E3A1E.4000708@st.com>
References: <e6eda088c6d3761ac4f5d1719489be61356e3a8a.1307591731.git.viresh.kumar@st.com> <4E2B4879.7000903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:41569 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750757Ab1GZEWy (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 Jul 2011 00:22:54 -0400
In-Reply-To: <4E2B4879.7000903@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "sshtylyov@mvista.com" <sshtylyov@mvista.com>


Hi Jeff,

On 07/24/2011 03:47 AM, Jeff Garzik wrote:
>> > +config ATA_DEBUG
>> > +        bool "ATA debugging"
>> > +        help
>> > +          This is an option for use by developers; most people should
>> > +          say N here.  This enables ATA core and driver debugging.
>> > +
>> > +config ATA_VDEBUG
>> > +        bool "ATA verbose debugging"
>> > +        depends on ATA_DEBUG
>> > +        help
>> > +          This is an option for use by developers; most people should
>> > +          say N here.  This enables deeper (more verbose) debugging of
>> > +          the ATA core and drivers.
>> > +
> There does not seem to be a large, driving need for this.  It is 
> straightforward to update the header file for the esoteric, voluminous 
> debugging.
> 

When i was debugging my code earlier, i found this more useful and
convenient over editing headers. We may need to do this in several
header files, if we don't have common header for two source files.
Also, having this as config option would be more helpful for people
who don't have much knowhow of "how dev_dbg and dev_vdbg works".

> If you are missing critical hardware or software errors, that is an 
> argument that those error messages should be outside of DEBUG/VDEBUG, 
> shipped with every kernel.

That's not my case. I wanted to print debug info.

-- 
viresh
