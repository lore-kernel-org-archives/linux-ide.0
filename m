From: Greg Freemyer <greg.freemyer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: SSD / filesystem / TRIM
Date: Tue, 31 Aug 2010 12:05:26 -0400
Message-ID: <AANLkTin+bc8vw0cpqaYeP6GNUe-ioxMTTy5CXC9ZquRf@mail.gmail.com>
References: <4C759825.60503@web.de>
	<AANLkTimrOOPExu+hU9wNubT3wgJWwUxMwjREn2p=x-qT@mail.gmail.com>
	<4C7A2949.8070606@web.de>
	<AANLkTinNt83RYu+ssRHzLT=E+Nk5kTk4Q+sfxQk5SP4+@mail.gmail.com>
	<4C7CF740.9040907@teksavvy.com>
	<AANLkTinBG0CjPZe1+ViHp9ir95sPvJ=XADT2a3LdbF3i@mail.gmail.com>
	<4C7CFDFD.5000902@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <opensuse-kernel+bounces-2017-glsk-opensuse-kernel=m.gmane.org-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Post: <mailto:opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:opensuse-kernel+help-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Subscribe: <mailto:opensuse-kernel+subscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <mailto:opensuse-kernel+unsubscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Owner: <mailto:opensuse-kernel+owner-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Archive: <http://lists.opensuse.org/opensuse-kernel/>
In-Reply-To: <4C7CFDFD.5000902-R6A+fiHC8nRWk0Htik3J/w@public.gmane.org>
To: Mark Lord <kernel-R6A+fiHC8nRWk0Htik3J/w@public.gmane.org>
Cc: Thomas Hertweck <Thomas.Hertweck-S0/GAf8tV78@public.gmane.org>, opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org, IDE/ATA development list <linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-ide@vger.kernel.org

On Tue, Aug 31, 2010 at 9:05 AM, Mark Lord <kernel-R6A+fiHC8nRWk0Htik3J/w@public.gmane.org> wrote:
> On 10-08-31 08:51 AM, Greg Freemyer wrote:
>>
>> Does hdparm v.9.30 have any known kernel dependencies that would keep
>> it from working with 2.6.31?
>>
>> Or any other known issues that would argue against opensuse pushing it
>> out as a software update for 11.2 and 11.3?
>>
>> Or at least putting it in a OBS repo so people using wiper.sh/hdparm
>> can use the latest if they load if from the repo..
>
>
> No issues that I know about.
> My own opinion, is that _anyone_ using hdparm should be using v9.30.
>
> Cheers

Mark, Thanks

Thomas, I opened a bugzilla about it:
https://bugzilla.novell.com/show_bug.cgi?id=635920

I hope you'll add yourself as a cc: and test hdparm v9.30 if and when
it is available for test.

Thanks
Greg
