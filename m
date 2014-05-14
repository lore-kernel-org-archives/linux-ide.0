From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: understanding non fis based switching
Date: Wed, 14 May 2014 15:59:46 -0400
Message-ID: <5373CB32.2040501@ubuntu.com>
References: <53587A1A.2060904@ubuntu.com> <5372E5AF.9020708@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:36177 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751052AbaENT7r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 14 May 2014 15:59:47 -0400
In-Reply-To: <5372E5AF.9020708@ubuntu.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 5/13/2014 11:40 PM, Phillip Susi wrote:
> So I would have thought that if you asked a disk drive with 64 mb
> of cache to read a few mb, then waited a second before issuing
> more commands, it would continue to read the next several mb into
> cache while waiting for new commands.  I wrote a simple benchmark
> to test this by reading 16 256k blocks ( with O_DIRECT from a
> random starting offset to start with cold cache ), sleeping for 1
> second, then reading the next 16, and the results seem to show that
> the drive stops reading ahead just after 1 MB.  Do drives really
> have such terrible readahead algorithms in general?  If so, this
> would seem to explain the terrible port multiplier performance in
> the absence of FBS.  If this is really the norm, then perhaps
> libata needs to do a better job of balancing requests between the
> drives?

I have been trying to follow the code to see how it switches back and
forth between the two drives, and what, if anything, is done to keep
that switching smooth and fair.  It looks like the libata layer just
returns an error to the scsi layer telling it to try the request again
later whenever the other disk has outstanding commands and holds the
port exclusively.  I can't find where in the scsi code it decides it
is time to retry that command, or if it does anything to stop any more
commands being issued to the first drive so it can free up the port so
the second drive can get a crack at it.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTc8svAAoJEI5FoCIzSKrw9/EIAJSV6wvL/BFeOpuv7M8Q6dQz
MExvhLe4dO/Nlc6bHr7I9bK6Pa1UL9vOmqpIbTDpmL2o8fQVri/0SVPrZ2fUw3BS
rmkq7md/eM875/NQAdExnZ8EQYzpevAOTobUnJSRkdtNvLFSmqK1HhZAipHmI1Bu
TW2Xy7pp7qj8qs/6Cc1Z+Ny60GY9yB6fVR6hlltL5M56wrBCT+q6vTeJatBvf8Ra
+E3Sxa/7X8Tv8/MQJ0oE1q5sMA3Vwz3Mrg+8cqr064SGD0JhDn7WwCOkxj3kQBIO
+K4wnQdkB3wUzQsm5CAnTztJTH2hrx6eR1RTac+9HncPqo0eMuXubupkhtb6KVU=
=kQSu
-----END PGP SIGNATURE-----
